

export const userLoggedIn = () => {
  if (global.sessionStorage.getItem('token')) {
    return true
  } else {
    return false
  }
}
