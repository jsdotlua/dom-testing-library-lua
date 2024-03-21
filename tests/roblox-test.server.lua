local ReplicatedStorage = game:GetService('ReplicatedStorage')

local jest = require('@pkg/@jsdotlua/jest')

local success, result = jest.runCLI(ReplicatedStorage, {
    color = false,
    colors = false,
}, { ReplicatedStorage:FindFirstChild('DomTestingLibrary') }):await()

if not success then
    error(result)
end

task.wait(0.5)
