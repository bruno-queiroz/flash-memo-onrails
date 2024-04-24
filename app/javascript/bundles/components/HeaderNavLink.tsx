import React from "react";

interface HeaderNavLinkProps {
  name: string;
  path: string;
}

export const HeaderNavLink = ({ name, path }: HeaderNavLinkProps) => {
  return (
    <a
      href={path}
      className={({ isActive }) =>
        isActive ? "dark:text-aqua-blue text-dark-blue font-semibold" : ""
      }
    >
      <div className="p-3 relative after:h-[2.5px] after:w-[0px] after:bg-dark-blue after:dark:bg-aqua-blue after:absolute after:bottom-0 after:left-0 after:transition-all after:duration-300 hover:after:w-full">
        {name}
      </div>
    </a>
  );
};
