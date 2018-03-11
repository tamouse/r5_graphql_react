import {
  isUserLoggedIn
} from "./index";

describe("isUserLoggedIn tests", ()=>{

  test("returns false when no token in sessionStorage",()=>{
    global.sessionStorage.clear()
    expect(isUserLoggedIn()).toBeFalsy()
  })

  test("returns true when a token in sessionStorage", ()=>{
    global.sessionStorage.getItem = key => key
    expect(isUserLoggedIn()).toBeTruthy()
    global.sessionStorage.getItem = jest.fn()
  })

})
