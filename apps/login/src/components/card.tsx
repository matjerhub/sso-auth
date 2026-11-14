import { clsx } from "clsx";
import { HTMLAttributes, ReactNode, forwardRef } from "react";

export interface CardProps extends HTMLAttributes<HTMLDivElement> {
  children: ReactNode;
  roundness?: string;
  padding?: string;
}

export const Card = forwardRef<HTMLDivElement, CardProps>(
  (
    {
      children,
      className = "",
      roundness = "rounded-lg", // 8px in the MatjerHub admin design system
      padding = "p-8",
      ...props
    },
    ref,
  ) => {
    const actualBackground = "bg-matjerhub-surface";
    const actualCardStyling = "shadow-sm border border-matjerhub-border";

    return (
      <div ref={ref} className={clsx(actualBackground, actualCardStyling, padding, roundness, className)} {...props}>
        {children}
      </div>
    );
  },
);
