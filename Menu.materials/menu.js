// Wait for jquery (loaded by vorple after this script)
document.addEventListener("DOMContentLoaded", async () => {
  // low effort mobile detection
  const isMobile =
    /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(
      navigator.userAgent
    );
  // virtual keyboard detection
  let hasVK = false;
  window.addEventListener("resize", () => {
    if (isMobile) {
      hasVK = true;
    }
  });

  let menu = {};
  // Expose these to Vorple.
  window.resetMenu = function () {
    menu = {};
    $(".in-scope").removeClass("in-scope");
  };
  window.addToMenu = function (id, command, text, icon) {
    menu[id] = menu[id] || [];
    if (command.includes(">")) {
      command = command.replace(/\s*>\s*/g, " ");
    }
    menu[id].push({ id, command, text, icon });
    $(`.object-id-${id}`).addClass("in-scope");
  };

  // Wait for the dependencies (in particular contextMenu which we call immediately after).
  await $.getScript("./jquery.contextMenu.min.js");
  try {
    await $.getScript("https://kit.fontawesome.com/f6a35de753.js");
  } catch (e) {
    // No icons today…
  }

  function getObjectID(link) {
    const match = link.className.match(/object-id-(\d+)/);
    return match ? match[1] : null;
  }

  function addItem(container, item) {
    // Sub-menus
    if (item.text.includes(">")) {
      const [_, submenu, rest] = item.text.match(/([^>]+)>(.+)/);
      // create submenu if it doesn't already exist
      container[submenu] = container[submenu] ?? {
        name: submenu,
        items: {},
      };
      addItem(container[submenu].items, {
        ...item,
        text: rest,
      });
    } else {
      container[item.command] = {
        name: item.text,
        icon: item.icon,
      };
    }
  }

  $(document.body).contextMenu({
    // Only in scope objects have a menu.
    selector: ".menu-link.in-scope",
    // Open on left click.
    trigger: "left",
    // Build the menu dynamically.
    build($el, ev) {
      // Get the object id.
      const id = getObjectID($el[0]);
      // Build the menus.
      const root = {};
      for (const item of menu[id]) {
        addItem(root, item);
      }
      return {
        callback(key, options) {
          // Here key = command
          vorple.prompt.submit(key);
        },
        items: root,
      };
    },

    events: {
      show(opt) {
        // refocus the input if a virtual keyboard was detected
        if (hasVK) {
          $("#lineinput-field").focus();
        }
      },
    },
  });
});
