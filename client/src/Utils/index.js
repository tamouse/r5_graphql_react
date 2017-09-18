

export const userLoggedIn = () => {
  if (window.sessionStorage.getItem('token')) {
    return true
  } else {
    return false
  }
}

