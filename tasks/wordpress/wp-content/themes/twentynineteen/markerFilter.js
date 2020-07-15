function markerFilter(){
    var bounds = new google.maps.LatLngBounds();
    var cc = document.getElementById("cc").value.trim().split(", ");
    if(document.getElementById("cc").value.trim().length!=0){
        if (/[0-9!@#\/$%\^\&*\)\(+=._-]/.test(cc[0])||/[0-9!@#\$%\^\&*\)\(+=._-]+/.test(cc[1])){
            alert("Invalid Input for City/Country! Use only alphabetical characters!");
            return;
        }
    }

    if(cc.length==1){
        var country=cc[0];
        var city=0;
    }
    else if(cc.length==2){
        var city=cc[0];
        var country=cc[1];
    }
    //var city = city;
//var country = country;
var x1 = document.getElementById("cords1").value.trim();
var x2 = document.getElementById("cords2").value.trim();
var x3 = document.getElementById("cords3").value.trim();
var x4 = document.getElementById("cords4").value.trim();
if(isNaN(x1)||isNaN(x2)||isNaN(x3)||isNaN(x4)){
    alert("Please type only numbers in the coordinate fields");
    return;
}
if(x1>90||x1<-90||x2>90||x2<-90||x3>180||x3<-180||x4>180||x4<-180){
    alert("Invalid Coordinates Input");
    return;
}
var counter1=0,counter2=0,counter3=0,counter4=0,pointscounter=0;	 if(document.getElementById("cc").value.trim().length==0&&document.getElementById("cords1").value.trim().length==0&&document.getElementById("cords2").value.trim().length==0&&document.getElementById("cords3").value.trim().length==0&&document.getElementById("cords4").value.trim().length==0){
return;
}


if(document.getElementById("cords1").value.trim().length!=0&&document.getElementById("cords2").value.trim().length!=0&&document.getElementById("cords3").value.trim().length!=0&&document.getElementById("cords4").value.trim().length!=0){
if(x1>x2||x3<x4){
    alert("Lower Left Point Latitude/Longtitude must be lower than Upper Right Point Latitude/Longtitude");
    return;
    }
for( i=0;i<map.markers.length;i++){
    if(city!=0&&country!=0){
if(map.markers[i].latitude>=x1&&map.markers[i].latitude<=x2&&map.markers[i].longtitude<=x3&&map.markers[i].longtitude>=x4&&map.markers[i].country==country&&map.markers[i].city==city){
counter4++;

}
    }
    else if(country!=0){
        if(map.markers[i].latitude>=x1&&map.markers[i].latitude<=x2&&map.markers[i].longtitude<=x3&&map.markers[i].longtitude>=x4&&map.markers[i].country==country){

counter4++;
}
    }
    else if(city!=0){
if(map.markers[i].latitude>=x1&&map.markers[i].latitude<=x2&&map.markers[i].longtitude<=x3&&map.markers[i].longtitude>=x4&&map.markers[i].city==city){

counter4++;
}
    }
    else if(city==0&&country==0){
        if(map.markers[i].latitude>=x1&&map.markers[i].latitude<=x2&&map.markers[i].longtitude<=x3&&map.markers[i].longtitude>=x4){
counter4++;

}
    }
}
if(counter4==0){
    alert("No matching locations were found in the database");
    return;
    }
} else if(document.getElementById("cords1").value.trim().length==0&&document.getElementById("cords2").value.trim().length==0&&document.getElementById("cords3").value.trim().length==0&&document.getElementById("cords4").value.trim().length==0){
for( i=0;i<map.markers.length;i++){
    if(map.markers[i].country==country&&map.markers[i].city==city){
    counter3++;
}
if(map.markers[i].country==country)
        counter1++;
if(map.markers[i].city==city)
        counter2++;
}
if((counter3==0)&&city!=0&&country!=0){
alert("The country and city combination was not found in the database");
return;
}
else if(counter1==0&&country!=0){
alert("The country was not found in the database");
return;
}
else if(counter2==0 && city!=0){
alert("The city was not found in the database");
return;
}
}
else if(document.getElementById("cords1").value.trim().length==0||document.getElementById("cords2").value==0||document.getElementById("cords3").value.trim().length==0||document.getElementById("cords4").value.trim().length==0){
alert("One or more of the coordinate boxes is left empty")
return;
}
for( i=0;i<map.markers.length;i++){
//map.markers[i].setMap(null);
    if(country!=0&&city==0&&document.getElementById("cords1").value.trim().length!=0&&document.getElementById("cords2").value.trim().length!=0&&document.getElementById("cords3").value.trim().length!=0&&document.getElementById("cords4").value.trim().length!=0){	 if(map.markers[i].latitude>=x1&&map.markers[i].latitude<=x2&&map.markers[i].longtitude<=x3&&map.markers[i].longtitude>=x4&&map.markers[i].country==country){
 bounds.extend(map.markers[i].position);

pointscounter++;
 }
}
else if(city!=0&&country!=0&&document.getElementById("cords1").value.trim().length!=0&&document.getElementById("cords2").value.trim().length!=0&&document.getElementById("cords3").value.trim().length!=0&&document.getElementById("cords4").value.trim().length!=0){	 if(map.markers[i].latitude>=x1&&map.markers[i].latitude<=x2&&map.markers[i].longtitude<=x3&&map.markers[i].longtitude>=x4&&map.markers[i].city==city&&map.markers[i].country==country){
 bounds.extend(map.markers[i].position);

pointscounter++;
 }
}
else if(document.getElementById("cords1").value.trim().length!=0&&document.getElementById("cords2").value.trim().length!=0&&document.getElementById("cords3").value.trim().length!=0&&document.getElementById("cords4").value.trim().length!=0){		  			 if(map.markers[i].latitude>=x1&&map.markers[i].latitude<=x2&&map.markers[i].longtitude<=x3&&map.markers[i].longtitude>=x4){
bounds.extend(map.markers[i].position);

pointscounter++;
}
}
else if(city!=0&&country!=0){
    if(map.markers[i].city==city&&map.markers[i].country==country){
        bounds.extend(map.markers[i].position);
        pointscounter++;
    }
}
else if(country!=0){
    if(map.markers[i].country==country){
        bounds.extend(map.markers[i].position);
        pointscounter++;
    }
}
else if(city!=0){
    if(map.markers[i].city==city){
        bounds.extend(map.markers[i].position);
        pointscounter++;
    }
}
}
map.fitBounds(bounds);
 document.getElementById("counter").innerHTML = pointscounter;
}