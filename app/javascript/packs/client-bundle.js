import ReactOnRails from "react-on-rails";

import { Header } from "../bundles/components/Header";
import { HeaderNavLink } from "../bundles/components/HeaderNavLink";
import { SignUp } from "../bundles/page/SignUp";
import { Form } from "../bundles/components/Form";
import { Input } from "../bundles/components/Input";
import { LoadSpinner } from "../bundles/components/LoadSpinner";
import { FormErrorMessage } from "../bundles/components/FormErrorMessage";

// This is how react_on_rails can see the HelloWorld in the browser.
ReactOnRails.register({
  SignUp,
  Form,
  FormErrorMessage,
  Input,
  LoadSpinner,
  Header,
  HeaderNavLink,
});
