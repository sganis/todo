import { json } from '@sveltejs/kit';
import prisma from '$lib/prisma';

export async function GET({ request }) {
	console.log('loading...');
	await new Promise((fulfil) => setTimeout(fulfil, 1000));
	const todos = await prisma.todo.findMany({
		orderBy: [
			{
				created_at: 'desc'
			}
		]
	});
	return json(todos, { status: 200 });
}

export async function POST({ request }) {
	const { text } = await request.json();
	const todo = await prisma.todo.create({
		data: {
			text,
			done: false,
			created_at: new Date()
		}
	});
	return json(todo, { status: 201 });
}
