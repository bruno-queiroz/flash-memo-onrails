import ReactOnRails from "react-on-rails";

import { Header } from "../bundles/components/Header";
import { HeaderNavLink } from "../bundles/components/HeaderNavLink";

// This is how react_on_rails can see the HelloWorld in the browser.
ReactOnRails.register({
  Header,
  HeaderNavLink,
});
