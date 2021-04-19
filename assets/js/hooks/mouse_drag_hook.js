let isDrawing = false;
let lastElement = null;

const getPositionFromEvent = (e) => ({
  x: e.pageX,
  y: e.pageY,
});
const getElementFromEvent = (e) => {
  const pos = getPositionFromEvent(e);
  return document.elementFromPoint(pos.x, pos.y);
};
const setLastElement = (el) => {
  lastElement = el;
};

const mouse_drag_hook = {
  mounted() {
    this.el.addEventListener("mousedown", (e) => {
      isDrawing = true;
      const element = getElementFromEvent(e);
      setLastElement(element);
    });
    this.el.addEventListener("mousemove", (e) => {
      if (isDrawing) {
        const element = getElementFromEvent(e);
        if (lastElement !== element && element.classList.contains("cell")) {
          element.click();
          setLastElement(element);
        }
      }
    });
    this.el.addEventListener("mouseup", (e) => {
      isDrawing = false;
    });
  },
};

export default mouse_drag_hook;
