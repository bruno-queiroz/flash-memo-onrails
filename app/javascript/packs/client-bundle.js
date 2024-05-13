import ReactOnRails from "react-on-rails";

import { Header } from "../bundles/components/Header";
import { SignUp } from "../bundles/pages/SignUp";
import { SignIn } from "../bundles/pages/SignIn";
import { App } from "../bundles/App";

ReactOnRails.register({
  SignUp,
  SignIn,
  Header,
  App,
});
