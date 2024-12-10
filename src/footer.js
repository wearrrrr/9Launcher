function toggleVisibility(element, animation) {
    if (element.opacity === 0) {
        element.visible = true;
        element.opacity = 1;
    } else {
        element.opacity = 0;
        if (animation) {
            animation.running = true;
        }
    }
}