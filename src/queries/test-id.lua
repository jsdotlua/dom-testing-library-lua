-- ROBLOX upstream: https://github.com/testing-library/dom-testing-library/blob/v8.14.0/src/queries/test-id.ts
local LuauPolyfill = require("@pkg/@jsdotlua/luau-polyfill")
type Array<T> = LuauPolyfill.Array<T>

local exports = {}

local checkContainerType = require("../helpers").checkContainerType
local wrapAllByQueryWithSuggestion = require("../query-helpers").wrapAllByQueryWithSuggestion
local typesModule = require("../types")
type AllByBoundAttribute<T = Instance> = typesModule.AllByBoundAttribute<T>
type GetErrorFunction<Argument = any> = typesModule.GetErrorFunction<Argument>
local all_utilsModule = require("./all-utils")
local queryAllByAttribute = all_utilsModule.queryAllByAttribute
local getConfig = all_utilsModule.getConfig
local buildQueries = all_utilsModule.buildQueries

local function getTestIdAttribute()
	return getConfig().testIdAttribute
end

local queryAllByTestId: AllByBoundAttribute
function queryAllByTestId(...: any)
	local args = { ... }
	checkContainerType(args[1])
	return queryAllByAttribute(getTestIdAttribute(), ...)
end

local getMultipleError: GetErrorFunction<unknown>
function getMultipleError(c, id)
	return ('Found multiple elements by: [%s="%s"]'):format(getTestIdAttribute(), tostring(id))
end
local getMissingError: GetErrorFunction<unknown>
function getMissingError(c, id)
	return ('Unable to find an element by: [%s="%s"]'):format(getTestIdAttribute(), tostring(id))
end

local queryAllByTestIdWithSuggestions =
	wrapAllByQueryWithSuggestion(queryAllByTestId, debug.info(queryAllByTestId, "n"), "queryAll")

-- ROBLOX deviation START: buildQueries returns a list
local queryByTestId, getAllByTestId, getByTestId, findAllByTestId, findByTestId =
	buildQueries(queryAllByTestId, getMultipleError, getMissingError)
-- ROBLOX deviation END

exports.queryByTestId = queryByTestId
exports.queryAllByTestId = queryAllByTestIdWithSuggestions
exports.getByTestId = getByTestId
exports.getAllByTestId = getAllByTestId
exports.findAllByTestId = findAllByTestId
exports.findByTestId = findByTestId

return exports
