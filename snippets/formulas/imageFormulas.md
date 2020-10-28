IMAGE( 
CASE( Priority, 
"Low", "/resource/1571928544000/icons/icons/Flag-yellow-icon.png",
"Medium", "/resource/1571928544000/icons/icons/Flag1-orange-icon.png",
"High", "/resource/1571928544000/icons/icons/Flag-red-icon.png", 
"/s.gif"), 
"Priority Flag", 18, 18)


IF (
    Priority_Number__c > 11,
    IMAGE("/img/samples/color_red.gif", "red", 30, 30),
    IF (
        Priority_Number__c > 4,
        IMAGE("/img/samples/color_yellow.gif", "yellow", 30, 30),
        IMAGE("/img/samples/color_green.gif", "green", 30, 30)
    )
)

IMAGE("/img/samples/color_red.gif", "red", Priority_Number__c, Priority_Number__c) & 
IMAGE("/s.gif", "white", Priority_Number__c, 
25 - (Priority_Number__c))


<img src="/img/samples/color_red.gif" alt="9" style="height:15px; width:9px;" border="0" data-aura-rendered-by="5708:0">
<img src="/img/samples/color_red.gif" alt="25" style="height:15px; width:25px;" border="0" data-aura-rendered-by="5708:0">

*******************************************************THIS ONE WORKS!!!!!********************************************************************

IMAGE("/img/samples/color_red.gif", LPAD(TEXT(Priority_Number__c),2,"0"), 15, Priority_Number__c * 2) & 
IMAGE("/s.gif", "white", 15, 
50 - (Priority_Number__c * 2))

**********************************************************************************************************************************************