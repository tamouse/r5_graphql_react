import {
  userLoggedIn
} from "./index";

describe("userLoggedIn tests", ()=>{

  test("returns false when no token in sessionStorage",()=>{
    global.sessionStorage.clear()
    expect(userLoggedIn()).toBeFalsy()
  })

  test("returns true when a token in sessionStorage", ()=>{
    global.sessionStorage.getItem = key => key
    expect(userLoggedIn()).toBeTruthy()
    global.sessionStorage.getItem = jest.fn()
  })

})
