-- First slash command
SLASH_ECHO1 = "/cmdecho"
SlashCmdList["ECHO"] = function(msg)
    print("Welcome to Azeroth, ", msg, "!")
end

-- Second slash command
SLASH_NULL1 = "/cmdnull"
SlashCmdList["NULL"] = function(msg)
    print("Welcome to Azeroth, Stranger!")
end

