-- ROBLOX upstream: https://github.com/testing-library/dom-testing-library/blob/v8.14.0/src/queries/placeholder-text.ts
local LuauPolyfill = require("@pkg/@jsdotlua/luau-polyfill")
type Array<T> = LuauPolyfill.Array<T>

local exports = {}

local wrapAllByQueryWithSuggestion = require("../query-helpers").wrapAllByQueryWithSuggestion
local checkContainerType = require("../helpers").checkContainerType
local typesModule = require("../types")
type AllByBoundAttribute<T = Instance> = typesModule.AllByBoundAttribute<T>
type GetErrorFunction<Argument = any> = typesModule.GetErrorFunction<Argument>
local all_utilsModule = require("./all-utils")
local queryAllByAttribute = all_utilsModule.queryAllByAttribute
local buildQueries = all_utilsModule.buildQueries

local queryAllByPlaceholderText: AllByBoundAttribute
function queryAllByPlaceholderText(...: any)
	local args = { ... }
	checkContainerType(args[1])
	return queryAllByAttribute("PlaceholderText", ...)
end

local getMultipleError: GetErrorFunction<Array<unknown>>
function getMultipleError(c, text)
	return ("Found multiple elements with the placeholder text of: %s"):format(tostring(text))
end
local getMissingError: GetErrorFunction<Array<unknown>>
function getMissingError(c, text)
	return ("Unable to find an element with the placeholder text of: %s"):format(tostring(text))
end

local queryAllByPlaceholderTextWithSuggestions =
	wrapAllByQueryWithSuggestion(queryAllByPlaceholderText, debug.info(queryAllByPlaceholderText, "n"), "queryAll")

-- ROBLOX deviation START: buildQueries returns a list
local queryByPlaceholderText, getAllByPlaceholderText, getByPlaceholderText, findAllByPlaceholderText, findByPlaceholderText =
	buildQueries(queryAllByPlaceholderText, getMultipleError, getMissingError)
--ROBLOX deviation END

exports.queryByPlaceholderText = queryByPlaceholderText
exports.queryAllByPlaceholderText = queryAllByPlaceholderTextWithSuggestions
exports.getByPlaceholderText = getByPlaceholderText
exports.getAllByPlaceholderText = getAllByPlaceholderText
exports.findAllByPlaceholderText = findAllByPlaceholderText
exports.findByPlaceholderText = findByPlaceholderText

return exports
