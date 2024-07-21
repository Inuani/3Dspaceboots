import { set_colors } from '$lib/color.js';

export const prerender = true;
export const ssr: boolean = false;

export function load({ }) {
    set_colors();
}
