package eclipsepe;

import org.eclipse.jface.text.*;
import org.eclipse.swt.SWT;
import org.eclipse.swt.widgets.Composite;
import org.eclipse.ui.IPartListener2;
import org.eclipse.ui.IPartService;
import org.eclipse.ui.IWorkbenchPartReference;
import org.eclipse.ui.PlatformUI;
import org.eclipse.ui.part.ViewPart;

public class EclipsePEView extends ViewPart {
	public static final String ID = "eclipsepe.EclipsePEView";

	private TextViewer viewer;
	private IPartService part_service;

	public EclipsePEView() {

	}

	public void createPartControl(Composite parent) {
		viewer = new TextViewer(parent, SWT.MULTI | SWT.V_SCROLL);
		viewer.setInput(this.getViewSite());
		viewer.setDocument(new Document());

		PlatformUI.getWorkbench().getHelpSystem()
				.setHelp(viewer.getControl(), "plugin_test.viewer");

		part_service = (IPartService) this.getSite().getService(IPartService.class);
		part_service.addPartListener(new PartListener());
	}

	protected class PartListener implements IPartListener2 {
		private String maybe_title(IWorkbenchPartReference reference) {
			return reference.getPart(false) == null ? "null" : (reference.getPart(false).getTitle()
					+ " -- " + reference.getPart(false).toString());
		}

		@Override
		public void partActivated(IWorkbenchPartReference partRef) {
			viewer.getDocument().set(
					"ACT: " + maybe_title(partRef) + "\n" + viewer.getDocument().get());
		}

		@Override
		public void partBroughtToTop(IWorkbenchPartReference partRef) {
			viewer.getDocument().set(
					"BTT: " + maybe_title(partRef) + "\n" + viewer.getDocument().get());
		}

		@Override
		public void partClosed(IWorkbenchPartReference partRef) {
			viewer.getDocument().set(
					"CLOSE: " + maybe_title(partRef) + "\n" + viewer.getDocument().get());
		}

		@Override
		public void partDeactivated(IWorkbenchPartReference partRef) {
			viewer.getDocument().set(
					"DEACT: " + maybe_title(partRef) + "\n" + viewer.getDocument().get());
		}

		@Override
		public void partOpened(IWorkbenchPartReference partRef) {
			viewer.getDocument().set(
					"OPEN: " + maybe_title(partRef) + "\n" + viewer.getDocument().get());
		}

		@Override
		public void partHidden(IWorkbenchPartReference partRef) {
			viewer.getDocument().set(
					"HIDE: " + maybe_title(partRef) + "\n" + viewer.getDocument().get());
		}

		@Override
		public void partVisible(IWorkbenchPartReference partRef) {
			viewer.getDocument().set(
					"VIS: " + maybe_title(partRef) + "\n" + viewer.getDocument().get());
		}

		@Override
		public void partInputChanged(IWorkbenchPartReference partRef) {
			viewer.getDocument().set(
					"INCHG: " + maybe_title(partRef) + "\n" + viewer.getDocument().get());
		}

	}

	public void setFocus() {
		viewer.getControl().setFocus();
	}

}