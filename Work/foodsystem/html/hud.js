var hungerLevel = parseInt($(".HungerLevel").text().trim());
var thirstLevel = parseInt($(".ThirstLevel").text().trim());

var HungerBar = $(".HungerLevel");
var ThirstBar = $(".ThirstLevel");

window.addEventListener("message", function(event) {
    var item = event.data;
    if (item.showhud) {
        HungerBar.fadeOut();
        ThirstBar.fadeOut();
    } else if (item.hidehud) {
        HungerBar.fadeIn();
        ThirstBar.fadeIn();
    }
    if (item.tick){
        let newhungerlevel = (item.hungerLevel);
        let newthirstlevel = (item.thirstLevel);
        $(".HungerLevel").attr('value', newhungerlevel);
        $(".ThirstLevel").attr('value', newthirstlevel);
    }
});