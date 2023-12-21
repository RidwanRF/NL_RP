
precent = 0.35 --// Eladási %
_markers = { --X,Y,Z
    {2156.9299316406, -1977.0736083984, 13.551800727844},
}

function format(n) 
    local left,num,right = string.match(n,'^([^%d]*%d)(%d*)(.-)$') 
    return left..(num:reverse():gsub('(%d%d%d)','%1,'):reverse())..right 
end