import { writable, get } from 'svelte/store';
import { createActor } from '../declarations/backend';
import { authStore } from '$lib/auth'; 
import type { ActorSubclass } from '@dfinity/agent';
import type { _SERVICE as BackendService } from '../declarations/backend/backend.did';

export const backendActor = writable<ActorSubclass<BackendService>>(undefined);

async function initBackendActor() {
    const canisterId = process.env.CANISTER_ID_BACKEND;
    const host = process.env.HOST;
    const storeValue = get(authStore);
    const userIdentity = storeValue.identity !== null ? storeValue.identity : undefined;

    const actor = createActor(canisterId, {
        agentOptions: {
            host: host,
            identity: userIdentity,
        }
    });

    backendActor.set(actor);
}

//update actor when authStore changes
authStore.subscribe(() => {
    initBackendActor();
});

