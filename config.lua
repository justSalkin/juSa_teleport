Config = {}

Config.dist = 40 --distance to load teleports

Config.Teleporter = { 
    {   name = "Upstairs Doc Valentine",
        blip = 60954128, --set to 0 to not show a blip | same position as the entrance | find blips here: https://filmcrz.github.io/blips/
        entrance = vector3(-282.32, 811.86, 121.53),
        exit = vector3(-284.13, 811.45, 121.66),
        jobs = false,    -- Jobs to enter {"job1","job2"} , or false for no job.
        items = {{dbname = "keysV", label = "Valentine Keys", amount = 1, removeitem = false}}, -- item(s) player needs in inventory to use teleporter | set to false for no item(s) needed
        drawEntrance = true, --set to false to create a "hidden" teleporter
        drawExit = true, 
        disableExitPrompt = false --set to true and drawExit to false to creat a one-way teleporter
    },
    {   name = "Doc Valentine",
        blip = 0,
        entrance = vector3(-280.42, 815.86, 118.36),
        exit = vector3(-281.76, 815.63, 118.39),
        jobs = {{name = "doctorV", label = "Doctor Valentine", grade = 3}, {name = "sheriffV", label = "Sheriff Valentine", grade = 5}},
        items = false,
        drawEntrance = true,
        drawExit = false, 
        disableExitPrompt = true
    },
    {   name = "Church Valentine",
        blip = 233295963, 
        entrance = vector3(-232.19, 796.19, 123.63),
        exit = vector3(-229.75, 797.39, 124.03),
        jobs = {{name = "priest", label = "Priest", grade = 3}},
        items = {{dbname = "keysV", label = "Valentine Keys", amount = 1, removeitem = false}, {dbname = "meat", label = "meat", amount = 1, removeitem = true}}, 
        drawEntrance = false, 
        drawExit = false, 
        disableExitPrompt = false
    },
}

---------------------- TRANSLATE HERE -------------------------------------
Config.Language = {
    enterPrompt = "~t4~Press [~t3~Enter~t4~] to enter",
    exitPrompt = "~t4~Press [~t3~Enter~t4~] to exit",
    noitem = "You'r missing an item: ",
    wrongjob = "You'v got the wrong job.",
    lowgrade = "Your job grade is to low.",
    notallowed = "You are not allowed to enter this place.",
    removeditem = "You used: "
}
------------------- Interaction -----------------
Config.keys = {
    Enter = 0xC7B5340A,
}