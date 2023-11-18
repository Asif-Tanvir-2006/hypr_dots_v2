#include <iostream>
#include <vector>
#include <sstream>
#include <cstdlib>
#include <cstdio>
#include <cstring>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

const char* active_char = "󰨑";
const char* inactive_char = "󰜌";

std::string generate_workspace_representation(int num_workspaces, int active_workspace) {
    std::vector<std::string> workspace_representation(num_workspaces, inactive_char);
    if (active_workspace >= 1 && active_workspace <= num_workspaces) {
        workspace_representation[active_workspace - 1] = active_char;
    }
    std::ostringstream oss;
    for (const std::string& symbol : workspace_representation) {
        oss << symbol << " ";
    }
    return oss.str();
}

int main(int argc, char* argv[]) {
    int active_workspace;

    if (argc != 2) {
        std::cerr << "Usage: " << argv[0] << " <active_workspace>" << std::endl;
        return 1;
    }

    if (sscanf(argv[1], "%d", &active_workspace) != 1 || active_workspace < 1 || active_workspace > 9) {
        std::cerr << "Error: Invalid active workspace. Please provide a number between 1 and 9." << std::endl;
        return 1;
    }

    int pipefd[2];
    if (pipe(pipefd) == -1) {
        perror("pipe");
        return 1;
    }

    pid_t pid = fork();

    if (pid == -1) {
        perror("fork");
        return 1;
    } else if (pid == 0) {  // Child process
        close(pipefd[0]);  // Close the read end of the pipe
        dup2(pipefd[1], STDOUT_FILENO);  // Redirect stdout to the write end of the pipe
        close(pipefd[1]);  // Close the write end of the pipe

        execlp("hyprctl", "hyprctl", "activeworkspace", nullptr);
        perror("execlp");
        return 1;
    } else {  // Parent process
        close(pipefd[1]);  // Close the write end of the pipe

        // Read the output from the child process
        char buffer[1024];
        std::string output_str;
        ssize_t bytes_read;
        while ((bytes_read = read(pipefd[0], buffer, sizeof(buffer))) > 0) {
            output_str.append(buffer, bytes_read);
        }
        close(pipefd[0]);  // Close the read end of the pipe

        // Find the line containing "workspace ID"
        size_t pos = output_str.find("workspace ID");
        if (pos != std::string::npos) {
            // Extract the workspace ID as a string between parentheses
            size_t start_pos = output_str.find('(', pos);
            size_t end_pos = output_str.find(')', start_pos);
            if (start_pos != std::string::npos && end_pos != std::string::npos) {
                std::string workspace_id_str = output_str.substr(start_pos + 1, end_pos - start_pos - 1);

                // Convert the workspace ID to an integer
                int workspace_id = std::atoi(workspace_id_str.c_str());

                // Generate and print the workspace representation
                std::string workspace_representation = generate_workspace_representation(active_workspace, workspace_id);
                std::cout << workspace_representation << std::endl;
            } else {
                std::cerr << "Error: Unable to extract workspace ID from output." << std::endl;
                return 1;
            }
        } else {
            std::cerr << "Error: Unable to determine the active workspace." << std::endl;
            return 1;
        }

        // Wait for the child process to exit
        int status;
        waitpid(pid, &status, 0);
        if (WIFEXITED(status) && WEXITSTATUS(status) != 0) {
            std::cerr << "Child process exited with an error." << std::endl;
            return 1;
        }
    }

    return 0;
}
