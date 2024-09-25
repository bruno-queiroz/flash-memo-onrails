let format = (interval: int) => {
  if interval >= 365 {
    let amount = interval / 365
    let precision = mod(interval, 365) * 10 / 365
    `${amount->Int.toString}.${precision->Int.toString}y`
  } else if interval >= 30 {
    let amount = interval / 30
    let precision = mod(interval, 30) * 10 / 30
    `${amount->Int.toString}.${precision->Int.toString}m`
  } else {
    `${interval->Int.toString}d`
  }
}
