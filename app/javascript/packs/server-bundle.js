import ReactOnRails from "react-on-rails";

import { Header } from "../bundles/components/Header";
import { SignIn } from "../bundles/pages/SignIn";
import { SignUp } from "../bundles/pages/SignUp";

ReactOnRails.register({
  Header,
  SignIn,
  SignUp,
});
