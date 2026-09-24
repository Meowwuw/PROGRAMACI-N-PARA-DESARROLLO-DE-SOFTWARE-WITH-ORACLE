fitty('#my-element', { minSize: 20,  maxSize: 300, multiLine: true });



// DARK MODE TOGGLE
if (localStorage.getItem('darkMode') === 'true') {
    $('#darkmode').addClass('toggled');
    $('body').addClass('darkmode');
}
if (localStorage.getItem('smoothMode') === 'true') {
    $('body').addClass('smooth');
}
$(function() {
    (function dark() {
        var $toggleDark = $('#darkmode');
        var $body = $('body');

        function dark() {
            if (!$body.hasClass('darkmode')) {
                $body.addClass('darkmode');
                $toggleDark.addClass('toggled');
                localStorage.setItem('darkMode', 'true');
            } else {
                $body.removeClass('darkmode');
                $toggleDark.removeClass('toggled');
                localStorage.removeItem('darkMode');
            }
        }

        $toggleDark.on('click', dark);
    })();
});
$(function() {
    (function menu() {
        var $toggleMenu = $('#menu');
        var $body = $('body');

        function menu() {
            if (!$body.hasClass('menu')) {
                $body.addClass('menu');
                $toggleMenu.addClass('toggled');
            } else {
                $body.removeClass('menu');
                $toggleMenu.removeClass('toggled');
            }
        }

        $toggleMenu.on('click', menu);
    })();
});
$(function() {
    (function smooth() {
        var $toggleSmooth = $('#smooth');
        var $body = $('body');

        function smooth() {
            if (!$body.hasClass('smooth')) {
                $body.addClass('smooth');
                localStorage.setItem('smoothMode', 'true');
            }
              
        }

        $toggleSmooth.on('click', smooth);
    })();
});
$(function() {
    (function rough() {
        var $toggleRough = $('#rough');
        var $body = $('body');

        function rough() {
            if ($body.hasClass('smooth')) {
                $body.removeClass('smooth');
                localStorage.removeItem('smoothMode');
            }
        }

        $toggleRough.on('click', rough);
    })();
});

// FONT SIZE CHANGER
(function() {
    const r = document.documentElement
    const f = localStorage.getItem("fontSize") || "14"
    r.style.setProperty("--fontSize", f + "px")
    localStorage.setItem("fontSize", f)
    
    const f2 = localStorage.getItem("lineHeight") || "23"
    r.style.setProperty("--lineHeight", f2 + "px")
    localStorage.setItem("lineHeight", f2)
  })()
  document.addEventListener("DOMContentLoaded", () => {
    const r = document.documentElement
    const cf = d => {
      let s = parseFloat(getComputedStyle(r).getPropertyValue("--fontSize")) || 14
      let n = Math.min(32, Math.max(8, s + d))
      r.style.setProperty("--fontSize", n + "px")
      localStorage.setItem("fontSize", n)
    }
    
    const cf2 = d2 => {
      let s2 = parseFloat(getComputedStyle(r).getPropertyValue("--lineHeight")) || 23
      let n2 = Math.min(41, Math.max(17, s2 + d2))
      r.style.setProperty("--lineHeight", n2 + "px")
      localStorage.setItem("lineHeight", n2)
    }
    document.getElementById("font-up").addEventListener("click", () => cf(1))
    document.getElementById("font-down").addEventListener("click", () => cf(-1))
    document.getElementById("font-reset").addEventListener("click", () => {
      r.style.setProperty("--fontSize", "14px")
      localStorage.setItem("fontSize", "14")
    })
    
    document.getElementById("font-up").addEventListener("click", () => cf2(1))
    document.getElementById("font-down").addEventListener("click", () => cf2(-1))
    document.getElementById("font-reset").addEventListener("click", () => {
      r.style.setProperty("--lineHeight", "23px")
      localStorage.setItem("lineHeight", "23")
    })
  })