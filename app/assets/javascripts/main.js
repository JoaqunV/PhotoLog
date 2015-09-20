

    jQuery.noConflict();

    /* tooltip for socials init */

    function tooltipInit() {

        jQuery("[data-toggle='tooltip']").tooltip();
    }


    function portfolioSort(){
        /*** Quicksand ***/
        var p = jQuery('#portfolio1');
        var f = jQuery('.filterPortfolio');
        var data = p.clone();
        f.find('a').click(function () {
            var link = jQuery(this);
            var li = link.parents('li');
            if (li.hasClass('active')) {
                return false;
            }

            f.find('li').removeClass('active');
            li.addClass('active');

            //quicksand
            var filtered = li.data('filter') ? data.find('li[data-filter~="' + li.data('filter') + '"]') : data.find('li');

            p.quicksand(filtered, {
	            duration:800,
	            adjustHeight: false,
                easing:'easeInOutQuad'}, function () { // callback function

                overlayContent('reload');

            });
            return false;
        });
    }



    function accordionActive() {

        jQuery(".accordion").on("show",function (e) {
            jQuery(e.target).prev(".accordion-heading").find(".accordion-toggle").addClass("active");
        }).on("hide",function (e) {
                jQuery(this).find(".accordion-toggle").not(jQuery(e.target)).removeClass("active");
            }).each(function () {
                var $a = jQuery(this);
                $a.find("a.accordion-toggle").attr("data-parent", "#" + $a.attr("id"));
            });
    }


	function fadeFlexsliderInit() {
        jQuery('.flexslider.fadeFlex').flexslider({
            animation: 'fade',
            animationLoop: false,
            slideshow: false,
            controlNav: false,               //Boolean: Create navigation for paging control of each clide? Note: Leave true for manualControls usage
            directionNav: true,
	        smoothHeight: true
        });
    }


    function carouselFlexsliderInit() {
        jQuery('.flexslider.flexCarousel').flexslider({
            animation: "slide",
            animationLoop: true,
            itemWidth: 140,                   //{NEW} Integer: Box-model width of individual carousel items, including horizontal borders and padding.
            minItems: 2,                    //{NEW} Integer: Minimum number of carousel items that should be visible. Items will resize fluidly when below this.
            maxItems: 6,                    //{NEW} Integer: Maxmimum number of carousel items that should be visible. Items will resize fluidly when above this limit.
            move: 0,                        //{NEW} Integer: Number of carousel items that should move on animation. If 0, slider will move all visible items.
            controlNav: false,               //Boolean: Create navigation for paging control of each clide? Note: Leave true for manualControls usage
            directionNav: true
          });
    }


    /* content on hover */
    function overlayContent(i) {
        if (i == 'init') {
            jQuery('.contentoverlay').contenthover({
                overlay_opacity: 0.6,
                effect: 'fade',                 // [fade, slide, show] The effect to use
                fade_speed: 400,                // Effect ducation for the 'fade' effect only
                slide_speed: 400,               // Effect ducation for the 'slide' effect only
                slide_direction: 'bottom'      // [top, bottom, right, left] From which direction should the overlay apear, for the slide effect only
            });
        }
        if (i == 'reload') {
            /* responsive overlay fix */
            jQuery('.ch_element').remove();
            jQuery('.contentoverlay').show();
            overlayContent('init');
        }
    }

    function mainsliderInit() {
	      jQuery('.flexslider.navmainslider').flexslider({
	        animation: "slide",
	        controlNav: false,
	        directionNav: false,
	        animationLoop: false,
	        slideshow: false,
	        itemWidth: 320,
	        itemMargin: 0,
	        minItems: 2,
	        maxItems: 2,
	        useCSS:false,
	        asNavFor: ".flexslider.mainslider"
	      });

	      jQuery('.flexslider.mainslider').flexslider({
	        animation: "slide",
	        controlNav: true,
	        animationLoop: false,
	        useCSS:false,
	        slideshow: false,
	        sync: ".flexslider.navmainslider",
	          start: function(){
	              var $mele = jQuery(".flexslider.mainslider .flex-control-nav li").size();
	              var $marginmele = 400 - $mele*14;

	            jQuery('.flexslider.mainslider .flex-direction-nav .flex-prev').css('margin-left', $marginmele);
	            jQuery('.flexslider.mainslider .flex-control-nav').css('margin-left', $marginmele+33);
	            jQuery(".flexslider.mainslider .flex-control-nav, .flexslider.mainslider .flex-direction-nav .flex-prev, .flexslider.mainslider .flex-direction-nav .flex-next").fadeIn();
	          }
	      });
    }


    /* link smooth scroll to top */
    function scrollToTop(i) {
        if (i == 'show') {
            if (jQuery(this).scrollTop() != 0) {
                jQuery('#toTop').fadeIn();
            } else {
                jQuery('#toTop').fadeOut();
            }
        }
        if (i == 'click') {
            jQuery('#toTop').click(function () {
                jQuery('body,html').animate({scrollTop: 0}, 600);
                return false;
            });
        }
    }


    jQuery(document).ready(function () {
        overlayContent('init');
         scrollToTop('click');
        accordionActive();
        portfolioSort();
        tooltipInit();
    });

    jQuery(window).resize(function () {
         overlayContent('reload');
    });

    jQuery(window).scroll(function () {
         scrollToTop('show');
    });

    jQuery(window).load(function () {
	     fadeFlexsliderInit();
        carouselFlexsliderInit();
	    mainsliderInit();
    });


