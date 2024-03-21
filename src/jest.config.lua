local ServerScriptService = game:GetService("ServerScriptService")

return {
	displayName = "Jest",
	setupFilesAfterEnv = { ServerScriptService:FindFirstChild("TestsSetup"):FindFirstChild("setup-env") },
	testMatch = { "**/__tests__/**/*.spec" },
}
