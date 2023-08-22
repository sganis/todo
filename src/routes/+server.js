import { json } from '@sveltejs/kit';
import prisma from '$lib/prisma';

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
