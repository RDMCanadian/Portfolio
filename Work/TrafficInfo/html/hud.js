$(function() {
    var speedContainer = $("#speedcontainer");
    var speedText = $(".speedtext");
    var speedSuffix = $(".speedkmh");
    var speedLimit = $(".speedlimit");
    
    window.addEventListener("message", function(event) {
        var item = event.data;
        if (item.showhud) {
            speedContainer.fadeIn();
            speedText.text(item.speed);
            speedSuffix.text(item.prefix)
            speedLimit.text(item.speedlimit)
        } else if (item.hidehud) {
            speedContainer.fadeOut();
        }
        if (Math.abs(item.speed - item.speedlimit) <= 10) {
            speedText.css({ color:'#FFA500' });
        }  else {
            speedText.css({ color:'#FFFFFF' });
        }
        if (item.speed >= item.speedlimit) {
            speedText.css({ color:'#FF0000' });
        }
    });
});