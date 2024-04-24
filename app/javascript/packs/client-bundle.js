import ReactOnRails from "react-on-rails";

import { Test } from "../bundles/components/Test";

// This is how react_on_rails can see the HelloWorld in the browser.
ReactOnRails.register({
  Test,
});
