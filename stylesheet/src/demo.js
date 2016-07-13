$(function() {

    var $b = $("body");

    if ($("#utils").length > 0) {
        var properties = ["padding", "padding--small","padding--big","margin","margin--small","margin--big", "border"];
        var modes = ["", "--top", "--bottom", "--left", "--right", "--vertical", "--horizontal"];
        $(properties).each(function(i, prop) {
            var $s = $("<article class='demo--property property__"+prop+"'> \n </article>");
            $(modes).each(function(i, mode) {
                var $c = $("    <div class='demo--col property-"+prop+"'> \n </div>\n");
                var property = prop + mode;
                $c.append($("    <div class='"+property+"'>."+property+"<br>."+property+"<br>."+property+"</div>"));
                $s.append($c);
            });
            $("#utils").append($s);
        });
    }


    if ($("#colors").length > 0) {
        var colors = ["fnx", "black", "white", "red", "pink", "purple",
            "deep-purple", "indigo", "blue", "light-blue", "cyan", "teal",
            "green", "light-green", "lime",
            "yellow","amber","orange","deep-orange","brown","grey","blue-grey"];
        $(colors).each(function(i, val) {
            $("#colors").append(
                $("<article class='s6 m3 l2'>\n" +
                    "   <div class='bg--"+val+"--l4'>.bg--"+val+"--l4</div>\n" +
                    "   <div class='bg--"+val+"--l3'>.bg--"+val+"--l3</div>\n" +
                    "   <div class='bg--"+val+"--l2'>.bg--"+val+"--l2</div>\n" +
                    "   <div class='bg--"+val+"--l1'>.bg--"+val+"--l1</div>\n" +
                    "   <div class='bg--"+val+"'>.bg--"+val+"</div>\n" +
                    "   <div class='bg--"+val+"--d1'>.bg--"+val+"--d1</div>\n" +
                    "   <div class='bg--"+val+"--d2'>.bg--"+val+"--d2</div>\n" +
                    "   <div class='bg--"+val+"--d3'>.bg--"+val+"--d3</div>\n" +
                    "   <div class='bg--"+val+"--d4'>.bg--"+val+"--d4</div>\n" +
                    "</article>")
            );
            $("#colors").append(
                $("<article class='s6 m3 l2'>\n" +
                    "   <div class='text--"+val+"--l4'>.text--"+val+"--l4</div>\n" +
                    "   <div class='text--"+val+"--l3'>.text--"+val+"--l3</div>\n" +
                    "   <div class='text--"+val+"--l2'>.text--"+val+"--l2</div>\n" +
                    "   <div class='text--"+val+"--l1'>.text--"+val+"--l1</div>\n" +
                    "   <div class='text--"+val+"'>.text--"+val+"</div>\n" +
                    "   <div class='text--"+val+"--d1'>.text--"+val+"--d1</div>\n" +
                    "   <div class='text--"+val+"--d2'>.text--"+val+"--d2</div>\n" +
                    "   <div class='text--"+val+"--d3'>.text--"+val+"--d3</div>\n" +
                    "   <div class='text--"+val+"--d4'>.text--"+val+"--d4</div>\n" +
                    "</article>")
            );
        });
    }

    $("article").on("mouseenter", function() {
        var $a = $(this);
        if ($a.data("code") == "true") return;
        $a.data("code", "true");
        $a.append($("<button class='button--code btn bg--red'><span class='mi'>code</span></button>"));
    });

    $("article").on("mouseleave", function() {
        var $a = $(this);
        if ($a.data("code") != "true") return;
        $a.data("code", null);
        $a.children(".button--code").remove();
    });

    $b.on("click", ".button--code", function() {
        var $a = $(this).parent();
        $a.children(".button--code").remove();
        $a.data("code", null);
        $b.append($('<div class="modal__wrapper" id="modalCode"><div class="modal"><a href="#" class="modal__close">close</a><div class="modal_code"></div></div></div>'));
        $("#modalCode .modal_code").text($a.html());
    });

    $b.on("click", "#modalCode .modal__close", function(e) {
       $("#modalCode").remove();
        e.preventDefault();
    });

    $b.on("click", "#demoOpenModalExample", function() {
       $("#demoModalExample").show();
    });

    $b.on("click", "#demoModalExample", function() {
        $("#demoModalExample").hide();
    });




});