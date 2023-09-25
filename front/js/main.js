(function ($) {
    "use strict";

    // Spinner
    var spinner = function () {
        setTimeout(function () {
            if ($('#spinner').length > 0) {
                $('#spinner').removeClass('show');
            }
        }, 1);
    };
    spinner();
    
    
    // Back to top button
    $(window).scroll(function () {
        if ($(this).scrollTop() > 300) {
            $('.back-to-top').fadeIn('slow');
        } else {
            $('.back-to-top').fadeOut('slow');
        }
    });
    $('.back-to-top').click(function () {
        $('html, body').animate({scrollTop: 0}, 1500, 'easeInOutExpo');
        return false;
    });


    // Sidebar Toggler
    $('.sidebar-toggler').click(function () {
        $('.sidebar, .content').toggleClass("open");
        return false;
    });


    // Progress Bar
    $('.pg-bar').waypoint(function () {
        $('.progress .progress-bar').each(function () {
            $(this).css("width", $(this).attr("aria-valuenow") + '%');
        });
    }, {offset: '80%'});


    // Calender
    $('#calender').datetimepicker({
        inline: true,
        format: 'L',
        locale: 'es'
    });


    // Testimonials carousel
    $(".testimonial-carousel").owlCarousel({
        autoplay: true,
        smartSpeed: 1000,
        items: 1,
        dots: true,
        loop: true,
        nav : false
    });


    // Chart Global Color
    Chart.defaults.color = "#6C7293";
    Chart.defaults.borderColor = "#000000";


    // Worldwide Sales Chart
    var ctx1 = $("#worldwide-sales").get(0).getContext("2d");
    var myChart1 = new Chart(ctx1, {
        type: "bar",
        data: {
            labels: ["Enero", "Febero", "Marzo", "Abril", "Mayo", "Junio", "Julio"],
            datasets: [{
                    label: "Ventas",
                    data: [15, 30, 55, 65, 60, 80, 95],
                    backgroundColor: "rgba(255, 204, 41, 1)"
                },
                {
                    label: "Compras",
                    data: [8, 35, 40, 60, 70, 55, 75],
                    backgroundColor: "rgba(255, 204, 41, 1)"
                },
                {
                    label: "Ilegales",
                    data: [12, 25, 45, 55, 65, 70, 60],
                    backgroundColor: "rgba(255, 204, 41, 1)"
                }
            ]
            },
        options: {
            responsive: true
        }
    });


    // Salse & Revenue Chart
    var ctx2 = $("#salse-revenue").get(0).getContext("2d");
    var myChart2 = new Chart(ctx2, {
        type: "line",
        data: {
            labels: ["Enero", "Febero", "Marzo", "Abril", "Mayo", "Junio", "Julio"],
            datasets: [{
                    label: "Stock Actual",
                    data: [15, 30, 55, 45, 70, 65, 85],
                    backgroundColor: "rgba(255, 204, 41, 1)",
                    fill: true
                },
                {
                    label: "Stock Máximo",
                    data: [99, 135, 170, 130, 190, 180, 270],
                    backgroundColor: "rgba(255, 204, 41, 1)",
                    fill: true
                }
            ]
            },
        options: {
            responsive: true
        }
    });
    


    // Single Line Chart
    var ctx3 = $("#line-chart").get(0).getContext("2d");
    var myChart3 = new Chart(ctx3, {
        type: "line",
        data: {
            labels: [50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150],
            datasets: [{
                label: "mostrar",
                fill: false,
                backgroundColor: "rgba(255, 204, 41, 1)",
                data: [7, 8, 8, 9, 9, 9, 10, 11, 14, 14, 15]
            }]
        },
        options: {
            responsive: true
        }
    });


    // Single Bar Chart
    var ctx4 = $("#bar-chart").get(0).getContext("2d");
    var myChart4 = new Chart(ctx4, {
        type: "bar",
        data: {
            labels: ["Enero", "Febrero", "Marzo", "Abril", "Mayo"],
            datasets: [{
                backgroundColor: [
                    "rgba(255, 204, 41, 1)",
                    "rgba(255, 204, 41, 1)",
                    "rgba(255, 204, 41, 1)",
                    "rgba(255, 204, 41, 1)",
                    "rgba(255, 204, 41, 1))"
                ],
                data: [55, 49, 44, 24, 15]
            }]
        },
        options: {
            responsive: true
        }
    });


    // Pie Chart
    var ctx5 = $("#pie-chart").get(0).getContext("2d");
    var myChart5 = new Chart(ctx5, {
        type: "pie",
        data: {
            labels: ["Enero", "Febrero", "Marzo", "Abril", "Mayo"],
            datasets: [{
                backgroundColor: [
                    "rgba(255, 204, 41, 1)",
                    "rgba(255, 204, 41, 1)",
                    "rgba(255, 204, 41, 1)",
                    "rgba(255, 204, 41, .8)",
                    "rgba(255, 204, 41, 1)"
                ],
                data: [55, 49, 44, 24, 15]
            }]
        },
        options: {
            responsive: true
        }
    });


    // Doughnut Chart
    var ctx6 = $("#doughnut-chart").get(0).getContext("2d");
    var myChart6 = new Chart(ctx6, {
        type: "doughnut",
        data: {
            labels: ["Enero", "Febrero", "Marzo", "Abril", "Mayo"],
            datasets: [{
                backgroundColor: [
                    "rgba(255, 204, 41, 1)",
                    "rgba(255, 204, 41, .3)",
                    "rgba(255, 204, 41, .4)",
                    "rgba(255, 204, 41, .6)",
                    "rgba(255, 204, 41, 1)"
                ],
                data: [55, 49, 44, 24, 15]
            }]
        },
        options: {
            responsive: true
        }
    });

    
})(jQuery);

