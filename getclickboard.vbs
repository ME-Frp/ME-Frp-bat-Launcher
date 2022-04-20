Set objHTML = CreateObject("htmlfile")
ClipboardText = objHTML.ParentWindow.ClipboardData.GetData("text")
path = "tmp.txt"
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objFile = objFSO.OpenTextFile(path, 2, true)
objFile.WriteLine ClipboardText
objFile.Close 
' https://www.it1352.com/328366.html