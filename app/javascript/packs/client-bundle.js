import ReactOnRails from "react-on-rails";

import { Header } from "../bundles/components/Header";
import { SignUp } from "../bundles/page/SignUp";
import { SignIn } from "../bundles/page/SignIn";

ReactOnRails.register({
  SignUp,
  SignIn,
  Header,
});
