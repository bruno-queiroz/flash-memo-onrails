import React, { useState } from "react";
import { IoCloseSharp as CloseIcon } from "react-icons/io5";
import { GiHamburgerMenu as MenuIcon } from "react-icons/gi";

import { BsFillSunFill as SunIcon } from "react-icons/bs";
import { BsFillMoonFill as MoonIcon } from "react-icons/bs";

import { HeaderNavLink } from "./HeaderNavLink";
import { deleteSignOut } from "../fetch/deleteSignOut";
import { useHeader } from "../hooks/useHeader";

interface HeaderProps {
  isUserSignedIn: boolean;
}

export const Header = ({ isUserSignedIn }: HeaderProps) => {
  const {
    isNavActive,
    isLoggingOut,
    setIsNavActive,
    changeTheme,
    isDarkMode,
    logOut,
  } = useHeader();

  return (
    <header className="max-w-[1100px] p-4 mx-auto dark:bg-neutral-800 bg-white">
      <div
        className={`${
          isNavActive ? "block" : "hidden"
        } fixed sm:hidden top-0 bottom-0 left-0 right-0 w-full h-full bg-[rgb(0,0,0,0.7)]`}
        onClick={() => setIsNavActive(false)}
      />
      <div className="flex items-center gap-4">
        <div
          className={`flex w-full gap-6 items-center ${
            !true && "justify-between"
          }`}
        >
          <a
            href="/"
            className="dark:text-white text-neutral-800 text-2xl font-bold"
          >
            Flash Memo
          </a>

          <nav
            className={`${
              isNavActive ? "translate-x-0" : "translate-x-[100%]"
            } flex flex-col sm:flex-1 transition-transform p-4 fixed right-0 h-full w-[50%] z-10 top-0 bottom-0 dark:bg-neutral-900 bg-gray-200 sm:dark:bg-neutral-800 reset-styles`}
          >
            <button
              className="text-primary-yellow text-3xl font-bold ml-auto sm:hidden"
              onClick={() => setIsNavActive(false)}
            >
              <CloseIcon />
            </button>
            <ul className="flex flex-col sm:flex-row dark:text-white">
              {isUserSignedIn ? (
                <>
                  <li onClick={() => setIsNavActive(false)}>
                    <HeaderNavLink name="Decks" path="/decks" />
                  </li>
                  <li onClick={() => setIsNavActive(false)}>
                    <HeaderNavLink name="Add" path="/add" />
                  </li>
                  <li onClick={() => setIsNavActive(false)}>
                    <HeaderNavLink name="Search" path="/search" />
                  </li>
                  <li
                    onClick={() => setIsNavActive(false)}
                    className="flex sm:flex-1 sm:justify-end p-3"
                  >
                    <button onClick={logOut}>
                      {isLoggingOut ? "Logging out..." : "Log Out"}
                    </button>
                  </li>
                </>
              ) : (
                <li
                  onClick={() => setIsNavActive(false)}
                  className="sm:flex sm:justify-end sm:flex-1 "
                >
                  <HeaderNavLink name="Sign in" path="/sign-in" />
                </li>
              )}
            </ul>
          </nav>
        </div>

        <div className="flex items-center gap-1">
          <div className="text-dark-blue dark:text-white">
            <MoonIcon />
          </div>
          <button
            className="w-[40px] h-[23px] bg-gray-200 dark:bg-neutral-500 rounded-[100vh] p-[3px]"
            onClick={changeTheme}
          >
            <div
              className={`w-[50%] h-full transition-transform rounded-[100%] bg-aqua-blue ${
                !isDarkMode ? "dark-theme-animation" : "light-theme-animation"
              }`}
            />
          </button>
          <div className="text-dark-blue dark:text-white">
            <SunIcon />
          </div>

          <button
            className="text-3xl text-dark-blue dark:text-gray-300 ml-4 sm:hidden"
            onClick={() => setIsNavActive(true)}
          >
            <MenuIcon />
          </button>
        </div>
      </div>
    </header>
  );
};
