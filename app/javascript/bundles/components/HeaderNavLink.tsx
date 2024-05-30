import React from "react";
import { BrowserRouter, Link } from "react-router-dom";

interface HeaderNavLinkProps {
  name: string;
  path: string;
}

export const HeaderNavLink = ({ name, path }: HeaderNavLinkProps) => {
  return (
    <Link to={path}>
      <div className="p-3 relative after:h-[2.5px] after:w-[0px] after:bg-dark-blue after:dark:bg-aqua-blue after:absolute after:bottom-0 after:left-0 after:transition-all after:duration-300 hover:after:w-full">
        {name}
      </div>
    </Link>
  );
};
