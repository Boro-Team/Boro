$(document).ready(function(){

$("ul.menu li:has(ul)").hover(function(){
$(this).find("ul").slideDown("fast");
},function(){
$(this).find("ul").slideUp("fast");
}
)

$("ul.menu > li").hover(function(){
$(this).addClass('current');
},function(){

$(this).removeClass('current');
});

$("ul.menu li a:has(ul)").addClass('with-child');


});
