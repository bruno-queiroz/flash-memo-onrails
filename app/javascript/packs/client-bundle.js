import ReactOnRails from "react-on-rails";

import { Header } from "../bundles/components/Header";
import { SignUp } from "../bundles/pages/SignUp";
import { SignIn } from "../bundles/pages/SignIn";

ReactOnRails.register({
  SignUp,
  SignIn,
  Header,
});
