type t = {
  isShowing: bool,
  isOk: bool,
  msg: string,
}

let useNotification = () => {
  let msg = Redux.useSelector((state: Store.t) => state.notification.content.msg)
  let isOk = Redux.useSelector((state: Store.t) => state.notification.content.isOk)
  let isShowing = Redux.useSelector((state: Store.t) => state.notification.content.isShowing)

  let dispatch = Redux.useDispatch()

  React.useEffect(() => {
    if isShowing {
      WebApi.setTimeout(() => {
        dispatch(
          NotificationSlice.setNotification({
            isOk,
            msg,
            isShowing: false,
          }),
        )
      }, 2000)
    }

    None
  }, [isShowing])

  {
    isShowing,
    isOk,
    msg,
  }
}
