

export const isUserLoggedIn = () => {
  if (global.sessionStorage.getItem('token')) {
    return true
  } else {
    return false
  }
}
