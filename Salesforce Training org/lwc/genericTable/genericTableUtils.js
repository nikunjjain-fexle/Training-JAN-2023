/*
Purpose         :   Utilities JS specific to generic table
Created By      :   Abhinav Sharma
Created Date    :   12/14/2022
Current Version :   v1.0
Revision Log    :   V_1.0 Created - Abhinav Sharma - 12/14/2022
*/
//Exporting a function
const listOfSplitedStrings = function(stringliteral)
{
    if(!Object.is(stringliteral, null) && !Object.is(stringliteral, '')) 
    {
        return stringliteral.split(',');
    }
}

export {listOfSplitedStrings};