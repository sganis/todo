<script>
	// @ts-nocheck
	import { fly, slide } from 'svelte/transition';
	import { enhance } from '$app/forms';
	import Todo from './Todo.svelte';
	const title = 'Todos';
	export let data;
	export let form;
	let todoInput;
	let working = false;
</script>

<svelte:head>
	<title>Todos</title>
</svelte:head>

<div class="todos">
	<h1>Todo</h1>
	<div class="saving">
		{#if working}
			saving...
		{:else}
			&nbsp;
		{/if}
	</div>
	{#if form?.error}
		<p class="error">{form.error}</p>
	{/if}

	<!-- use:enhance={() => {
		working = true;
		return async ({ update, result }) => {
			await update();
			working = false;
		};
	}} -->

	<div class="new">
		<form>
			<input
				type="text"
				name="text"
				value={form?.text ?? ''}
				disabled={working}
				bind:this={todoInput}
				aria-label="Add a todo"
				placeholder="Add a todo"
				autocomplete="off"
				on:keydown={async (e) => {
					if (e.key === 'Enter') {
						e.preventDefault();
						working = true;
						const input = e.currentTarget;
						const text = input.value;
						const response = await fetch('/', {
							method: 'POST',
							body: JSON.stringify({ text }),
							headers: {
								'Content-Type': 'application/json'
							}
						});
						const todo_db = await response.json();
						data.todos = [todo_db, ...data.todos];
						input.value = '';
						working = false;
					}
				}}
			/>
		</form>
	</div>
	{#each data.todos as todo (todo.id)}
		<div in:fly={{ y: 20 }} out:slide>
			<Todo {todo} bind:working />
		</div>
	{/each}
</div>

<style>
	.todos {
		width: 100%;
		max-width: 42rem;
		margin: 4rem auto 0 auto;
	}

	.new {
		margin: 0 0 0.5rem 0;
		padding: 0.5rem;
		background-color: white;
		border-radius: 8px;
		filter: drop-shadow(2px 4px 6px rgba(0, 0, 0, 0.1));
		transform: translate(-1px, -1px);
		transition: filter 0.2s, transform 0.2s;
	}

	.new input {
		font-size: 20px;
		width: 100%;
		padding: 0.5em 1em 0.3em 0.5em;
		box-sizing: border-box;
		background: rgba(255, 255, 255, 0.05);
		border-radius: 8px;
	}

	.todos :global(input) {
		border: 1px solid transparent;
	}

	.todos :global(input:focus-visible) {
		box-shadow: inset 1px 1px 6px rgba(0, 0, 0, 0.1);
		border: 1px solid #ff3e00 !important;
		outline: none;
	}
	.saving {
		text-align: right;
		margin: 1em;
		opacity: 0.5;
	}
</style>
