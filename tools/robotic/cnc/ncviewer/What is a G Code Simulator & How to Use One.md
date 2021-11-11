# What is a G Code Simulator & How to Use One

[DIY Machining](https://diymachining.com/) > [General](https://diymachining.com/category/general/) > What is a G Code Simulator & How to Use One



------

I’m a hobby machinist, why do I need a g code simulator? I asked the same question for a long time. However, as I learned more about CNC machining, I found myself using a g code simulator to save time. Say you have a g code program that you just created or downloaded. How do you know if it will work? You could take it to your machine and set your x, y & z origin (0,0,0) location safely away from the work table and then run the program. What if something doesn’t work they way you expect and you need to modify the g code. Or worse, you damage your machine. This is where a g code simulator can really help.

### Introduction

I started using a g code simulator when I was experimenting with engraving programs. That is, programs the generate g code to engrave text. I didn’t trust the g code the programs were generating. I wanted a way to test the g code. This was a perfect case for a g code simulator. I could test the g code without risking my machine or walking downstairs into the garage.

### What is a G Code Simulator

A g code simulator or g code viewer is a software tool that lets you test g code you created. The software reads the .nc file just as your CNC machine would and creates a graphical representation of the tool paths and movements of the machine.

### NC Viewer – The G Code Simulator I Use

Ok, so I want to use a g code simulator, where do I get one? My favorite is called [NC Viewer](https://ncviewer.com/) a free browser based tool. This runs directly in your browser window. No need to download or install a program. It’s also mobile friendly.

Click the link below to check it out…

#### <https://ncviewer.com/>

### How to Use a G Code Simulator

The following is specific to NC Viewer but the process will be similar for other simulators. The main screen of NC Viewer is annotated in the image below with the key functions of the tool.

 

![Screen Shot of NC Viewer G Code Simulator with annotations for the main functions of the tool](http://www.diymachining.com/wp-content/uploads/2019/02/NC_Viewer_Screen_Layout.jpg)

Main Features of NC Viewer

####     Step 1 – Click the link to navigate to [NC Viewer](https://ncviewer.com/).

####     Step 2 – Load you G Code into the program.

You can either use the file menu in the top left portion of the window or copy and past your g code into the g code window on the left.

####     Step 3 – Click the “Plot” button in the G Code window

####     Step 4 – Click the “Play” button in the plot area to see a simulation of your g code.

You can also step through the code line by line. To step through the G Code line by line, click a line of G Code in the G Code window and us the up and down arrow keys.

#### User Tip – If you do not see a tool path, try zooming out or panning around the screen.

### Tips for Using a G Code Simulator

The following list of tips will help you get the most out of looking at your g code in NC Viewer.

####      1 – The origin

The X, Y, Z = 0 location is represented by the intersection of the red green and blue lines. This is very helpful if you are not exactly sure where to set the origin when setting up your part on the machine.

####     2 – Zoom, Pan & Rotate

The plot area image can be manipulated by using the view cube in the top right section of the plot area. For example, this is helpful if you want to confirm the Z = 0 location relative to the tool paths.

####     3 – Reset the View

If you want to restore the original view, simply click the “Home” button in the top right section of the plot window. This is helpful if the rotating gets away from you. It’s a quick way to reset the plot view.

####     4 –Find G Code

If you want to find a line of G code from the plot window, you simply click on the section of the tool path and the line of G code is highlighted in the G code window.

### Conclusion

A G Code Simulator is a great tool for hobbyists and professionals alike. I don’t use an external simulator every time. If I am making my G Code in Fusion360 then I use the build in simulator feature. However, if I am using another program, I run a simulation in NC Viewer before taking the code to my machine.

Special thanks to Xander Luciano the creator of NC Viewer. I appreciate the tool you created and your willingness to share it with the machining community. Check him out on Instagram [@XanderLuciano](https://www.instagram.com/xanderluciano/)

Thanks for reading. Until next time… Tim