// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract TodoList {
    uint public taskCount = 0;

    struct Task {
        uint id;
        string content;
        bool completed;
    }

    // Mapping from user address to their tasks
    mapping(address => mapping(uint => Task)) public tasks;
    mapping(address => uint) public userTaskCount;

    event TaskCreated(address user, uint id, string content, bool completed);
    event TaskCompleted(address user, uint id, bool completed);

    // Function to create a new task for the sender
    function createTask(string memory _content) public {
        userTaskCount[msg.sender]++;
        uint newTaskId = userTaskCount[msg.sender];
        tasks[msg.sender][newTaskId] = Task(newTaskId, _content, false);
        emit TaskCreated(msg.sender, newTaskId, _content, false);
    }
}