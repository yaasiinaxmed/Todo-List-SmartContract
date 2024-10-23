// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract TodoList {
    uint256 public taskCount = 0;

    struct Task {
        uint256 id;
        string content;
        bool completed;
    }

    // Mapping from user address to their tasks
    mapping(address => mapping(uint256 => Task)) public tasks;
    mapping(address => uint256) public userTaskCount;

    event TaskCreated(address user, uint256 id, string content, bool completed);
    event TaskCompleted(address user, uint256 id, bool completed);

    // Function to create a new task for the sender
    function createTask(string memory _content) public {
        userTaskCount[msg.sender]++;
        uint256 newTaskId = userTaskCount[msg.sender];
        tasks[msg.sender][newTaskId] = Task(newTaskId, _content, false);
        emit TaskCreated(msg.sender, newTaskId, _content, false);
    }

    // Function to mark a task as completed for the sender
    function toggleTaskCompleted(uint256 _id) public {
        Task storage task = tasks[msg.sender][_id];
        require(task.id != 0, "Task not found"); //Ensure task exists
        task.completed = !task.completed;
        emit TaskCompleted(msg.sender, _id, task.completed);
    }
}
