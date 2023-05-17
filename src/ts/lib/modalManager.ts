import tingle from 'tingle.js';

function createNewModal(options: Object) {
    let modal = new tingle.modal(options);
    return modal
}
function openModal(modal: tingle.modal) {
    modal.open();
}

function closeModal(modal: tingle.modal) {
    modal.close();
}

const functions = {
    createNewModal,
    openModal,
    closeModal,
    
}

export default functions;