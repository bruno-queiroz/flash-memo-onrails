import ReactOnRails from "react-on-rails";
import { make as App } from "../bundles/App.res.mjs"
import { make as SignIn } from "../bundles/pages/SignIn.res.mjs"
import { make as SignUp } from "../bundles/pages/SignUp.res.mjs"

ReactOnRails.register({
 App,
 SignIn,
 SignUp
});
