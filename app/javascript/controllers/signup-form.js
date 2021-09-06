import {Controller} from 'stimulus';

export default class extends Controller {
  static targets = [
    'name', 'nameLabel', 'nameError',
    'email', 'emailLabel', 'emailError',
    'password', 'passwordLabel', 'passwordError',
    'passwordConfirmation', 'passwordConfirmationLabel', 'passwordConfirmationError',
    'form']

  get validName() {
    return this.nameTarget.checkValidity();
  }

  showNameValidation() {
    if (this.validName) {
      this.nameLabelTarget.classList.remove('hidden');
      this.nameErrorTarget.classList.add('hidden');
    } else {
      this.nameLabelTarget.classList.add('hidden');
      this.nameErrorTarget.classList.remove('hidden');
      this.nameErrorTarget.innerHTML = 'name is required';
    }
  }

  get validEmail() {
    return this.emailTarget.checkValidity();
  }
