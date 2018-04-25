---
layout: post
title: Replacing the Screen on the Lenovo Thinkpad X220
date: 2015-02-13
landing-image: "/assets/images/posts/x220-diagram.png"
comments: true
---

Back in 2011, I purchased a Thinkpad X220 to replace my aging Thinkpad T61. It's a great laptop, serving me well for just about four years now!  Unfortunately, my screen recently began exhibiting **the "vertical line" issue**, which is basically a vertical strip of discoloration along a part of the screen. You can read more about this common issue on [Thinkpad Forums](http://forum.thinkpads.com/viewtopic.php?f=43&t=96474), [Notebook Review](http://forum.notebookreview.com/threads/vertical-band-on-x220-ips-screen.700267/), or [this Youtube video](https://www.youtube.com/watch?v=rM9_ZM_8qkQ).

After four years without any major problems, my X220 was finally showing its age. However, it's really easy to replace the LCD panel on the X220 (or any Thinkpad for that matter)!

Tools required:

* a small Philips screwdriver
* a flat-head screwdriver(for prying)

## Finding the Correct Replacement LCD

Lenovo provides a **system service parts list document** for most of their products. Each document contains a diagram of all the components and information about each part. This is part of the diagram from the [X220 System Parts List](http://support.lenovo.com/us/en/documents/pd013599#1):

[![Jekyll CSS](/assets/images/posts/x220-diagram.png){: .bordered }](/assets/images/posts/x220-diagram.png)

Navigating through the diagram, I found the [LED Premuim LCD Service Parts List](http://support.lenovo.com/us/en/documents/migr-77193).  (*Note: This is for X220s with the IPS screen option.*) By clicking the LCD panel on the diagram, I was redirected to the following table:

<table border="1">
<tr>
<th colspan="4">LCD panel, 12.5-in. HD LED backlight</th>
</tr>
<tr>
<th colspan="2">Product ID</th>
<th>FRU</th>
<th>CRU</th>
</tr>
<tr>
<td colspan="2">
4286-CTO, 23x, 24x, 25x, 36x, 37x, 3Ux, 3Yx, 42x, 4Nx, 4Qx
<br/>
4287-CTO, 2Ax, 2Dx, 2Ex, 2Fx, 2Lx, 2Mx, 2Sx, 2Tx, 3Hx, 3Kx, 3Px, 3Qx, 4Rx, 4Vx, 4Wx,59x, 5Ax, 5Xx, 5Yx, 6Cx, 6Fx, 6Gx 
<br/>
4289-CTO 
<br/>
4290-CTO, 2Hx, 2Jx, 2Mx, 2Nx, 2Qx, 2Wx, 33x, 34x, 35x, 3Xx, 3Zx, 42x, 47x, 48x, 4Fx,4Lx, 4Sx, 4Tx, 4Ux, 4Xx, 4Yx, 4Zx, 52x, 53x, 57x, 58x, 5Gx 
<br/>
4291-CTO, 2Ex, 2Ux, 2Vx, 2Wx, 2Zx, 42x, 47x, 48x, 49x, 4Ax, 4Bx, 4Cx, 4Xx
</td>
<td>93P5675</td>
<td>N</td>
</tr>
</table>

Let's break down and define each section:

<table style="text-align: left">

<tr>
<th style="padding: 2px; border-bottom: 1px solid #CCC; vertical-align: top">Product ID:</th>
<td style="padding: 2px; border-bottom: 1px solid #CCC; vertical-align: top">The Product ID can be found on a sticker underneath the laptop, over to the left. Depending on the configuration of the laptop, this ID will vary.</td>
</tr>

<tr>
<th style="padding: 2px; border-bottom: 1px solid #CCC; vertical-align: top">Field Replaceable Unit (FRU) ID:</th> 
<td style="padding: 2px; border-bottom: 1px solid #CCC; vertical-align: top">An FRU ID is a 7-digit number used to identity specific components in a system. Service technicians can use this number to easily find and ensure a direct replacement for a defective part.</td>
</tr>

<tr>
<th style="padding: 2px; border-bottom: 1px solid #CCC; vertical-align: top">Customer Replaceable Unit (CRU) ID:</th>
<td style="padding: 2px; border-bottom: 1px solid #CCC; vertical-align: top">
A CRU ID is a single-digit number used to specify the difficulty level of replacing a component in a system for a customer. The following describes what each value means:
<br/>
<br/>

1 = easy to replace with little or no tools
<br/>
2 = more difficult to replace
<br/>
N = customer should not replace

</td>
</tr>

</table>

My Product ID happens to be **4286-CTO**. However, the table tells us it doesn't matter what the Product ID is. The FRU is the same for all of them! Using the FRU, **93P5675**, it should be relatively easy to find a suitable replacement for my broken LCD panel!

## Shopping for a Good LCD

There are several places online you can find decent replacement laptop components. I've only had experiences buying LCDs from two stores: [Screen Country](http://www.screencountry.com/) and [East Coast LCDs](http://www.eastcoastlcds.com/). Both are really easy to use and have decent pricing. A quick search for the FRU on East Coast LCDs led me to the [exact LCD panel I needed](http://east-coast-lcds.hostedbyamazon.com/LENOVO-93P5675-LAPTOP-SUBSTITUTE-REPLACEMENT/dp/B0074ALQH0/)!

[![East Coast LCD](/assets/images/posts/east-coast-lcd.png){: .bordered }](/assets/images/posts/east-coast-lcd.png)

There are many other online vendors that sell replacement parts (eBay, Amazon, AliExpress). A simple [Google search of the FRU yields some pretty good results](http://bit.ly/1EjFAUX)!

As of now, the **average price for an X220 replacement LCD is about \$45-\$70, shipped**.

## LCD Panel Removal and Replacement

Lenovo provides instructions on how to remove and replace the LCD in the [X220 Hardware Maintenance Manual](http://download.lenovo.com/ibmdl/pub/pc/pccbbs/mobiles_pdf/0a60739.pdf).  I found [this Youtube video](https://www.youtube.com/watch?v=7RwO6ZlyzGA) extremely helpful.

The following is my step-by-step process.

---

### Remove the battery.

[![](/assets/images/posts/x220-1.jpg){: .bordered }](/assets/images/posts/x220-1.jpg)

[![](/assets/images/posts/x220-2.jpg){: .bordered }](/assets/images/posts/x220-2.jpg)

---

### Using a flat-head screwdriver (or knife), gently pry off the screw covers on the front bezel of the LCD housing.

[![](/assets/images/posts/x220-3.jpg){: .bordered }](/assets/images/posts/x220-3.jpg)

[![](/assets/images/posts/x220-4.jpg){: .bordered }](/assets/images/posts/x220-4.jpg)

[![](/assets/images/posts/x220-5.jpg){: .bordered }](/assets/images/posts/x220-5.jpg)

---

### Using a Philips screwdriver, remove the screws holding the bezel in place.

[![](/assets/images/posts/x220-6.jpg){: .bordered }](/assets/images/posts/x220-6.jpg)

[![](/assets/images/posts/x220-7.jpg){: .bordered }](/assets/images/posts/x220-7.jpg)

---

### With the aid of a flat-head screwdriver, gently pop the bezel off along the edges. The bottom is tricky. Be patient!

[![](/assets/images/posts/x220-8.jpg){: .bordered }](/assets/images/posts/x220-8.jpg)

[![](/assets/images/posts/x220-9.jpg){: .bordered }](/assets/images/posts/x220-9.jpg)

[![](/assets/images/posts/x220-10.jpg){: .bordered }](/assets/images/posts/x220-10.jpg)

[![](/assets/images/posts/x220-11.jpg){: .bordered }](/assets/images/posts/x220-11.jpg)

---

### There are four screws holding the LCD panel to the housing. Remove these with a Philips screwdriver.

[![](/assets/images/posts/x220-12.jpg){: .bordered }](/assets/images/posts/x220-12.jpg)

[![](/assets/images/posts/x220-13.jpg){: .bordered }](/assets/images/posts/x220-13.jpg)

[![](/assets/images/posts/x220-14.jpg){: .bordered }](/assets/images/posts/x220-14.jpg)

[![](/assets/images/posts/x220-15.jpg){: .bordered }](/assets/images/posts/x220-15.jpg)

[![](/assets/images/posts/x220-16.jpg){: .bordered }](/assets/images/posts/x220-16.jpg)

---

### There are three more screws attaching the LCD panel to the hinges. Remove these with a Philips screwdriver.

[![](/assets/images/posts/x220-17.jpg){: .bordered }](/assets/images/posts/x220-17.jpg)

[![](/assets/images/posts/x220-18.jpg){: .bordered }](/assets/images/posts/x220-18.jpg)

[![](/assets/images/posts/x220-19.jpg){: .bordered }](/assets/images/posts/x220-19.jpg)

[![](/assets/images/posts/x220-20.jpg){: .bordered }](/assets/images/posts/x220-20.jpg)

---

### Using a flat-head, gently lift the LCD panel up and off the housing, but not all the way off! It is still attached to the motherboard by the LCD cable.

[![](/assets/images/posts/x220-21.jpg){: .bordered }](/assets/images/posts/x220-21.jpg)

[![](/assets/images/posts/x220-22.jpg){: .bordered }](/assets/images/posts/x220-22.jpg)

---

### Flip the LCD panel over to the backside and locate the LCD cable near the bottom.

[![](/assets/images/posts/x220-23.jpg){: .bordered }](/assets/images/posts/x220-23.jpg)

[![](/assets/images/posts/x220-24.jpg){: .bordered }](/assets/images/posts/x220-24.jpg)

---

### There is a piece of tape securing the LCD cable to the panel. Gently remove the tape and slide the LCD cable down and out.

[![](/assets/images/posts/x220-25.jpg){: .bordered }](/assets/images/posts/x220-25.jpg)

[![](/assets/images/posts/x220-26.jpg){: .bordered }](/assets/images/posts/x220-26.jpg)

---

### Voila! The LCD panel can now be fully removed from the LCD housing.

[![](/assets/images/posts/x220-27.jpg){: .bordered }](/assets/images/posts/x220-27.jpg)

---

### This is the new panel, packaged very securely by East Coast LCDs!

[![](/assets/images/posts/x220-28.jpg){: .bordered }](/assets/images/posts/x220-28.jpg)

[![](/assets/images/posts/x220-29.jpg){: .bordered }](/assets/images/posts/x220-29.jpg)

---

### Now, just do the reverse! Reattach the LCD cable to the new LCD panel.

[![](/assets/images/posts/x220-30.jpg){: .bordered }](/assets/images/posts/x220-30.jpg)

[![](/assets/images/posts/x220-31.jpg){: .bordered }](/assets/images/posts/x220-31.jpg)

[![](/assets/images/posts/x220-32.jpg){: .bordered }](/assets/images/posts/x220-32.jpg)

---

### Before screwing everything back in, make sure things work. Looking good so far!

[![](/assets/images/posts/x220-33.jpg){: .bordered }](/assets/images/posts/x220-33.jpg)

[![](/assets/images/posts/x220-34.jpg){: .bordered }](/assets/images/posts/x220-34.jpg)

---

### After screwing everything back in, remove the protective plastic left on the new LCD panel.

[![](/assets/images/posts/x220-35.jpg){: .bordered }](/assets/images/posts/x220-35.jpg)

---

### Good as new!

[![](/assets/images/posts/x220-36.jpg){: .bordered }](/assets/images/posts/x220-36.jpg)

## Conclusion

Thinkpads are really easy to modify and repair. In addition to replacing my broken screen, I ripped out the keyboard for cleaning and installed a new 128 GB solid-state drive. I have even more plans to upgrade the memory to 8 GB from 4 GB. My X220 has never been better and will, hopefully, continue to last a very long time!

Have any comments, questions, critiques? Let me know below. Happy tweaking!
