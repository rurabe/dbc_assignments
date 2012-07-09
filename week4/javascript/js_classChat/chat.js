$(function() {

    $("input").keydown (function(e) {
        if(e.which === 13) {
            var message = $(this).val();
            helpers.sendMessage(message);
            $(this).val("");
        };
    });


    setInterval(function(){
        helpers.fetchNewMessages(function(messages){
            $.each(messages,function(index,value){
                var $messages = $('.messages')
                $('<li class="message"/>').html($('<button class="btn disabled"/>').text(value).fadeIn(400)).prependTo($messages);
            })
        })
    },1000)
});
