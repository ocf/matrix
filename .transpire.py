from pathlib import Path
from transpire.resources import Service, StatefulSet, Ingress, Deployment, ConfigMap

name = "matrix"


def objects():
    #
    # Synapse
    #

    sts_synapse = StatefulSet(
        name="synapse",
        image="matrixdotorg/synapse:latest",
        ports=[8008],
        service_name="synapse",
    ).with_volume_template(
        name="data",
        size="16Gi",
        access_modes=["ReadWriteOnce"],
    )
    sts_synapse.pod_spec().with_pvc_volume(
        name="data",
        mount_path="/data",
    )
    yield sts_synapse

    svc_synapse = Service(
        name="synapse",
        selector=sts_synapse.get_selector(),
        port_on_pod=8008,
        port_on_service=80,
    )
    yield svc_synapse

    yield Ingress.from_svc(
        svc_synapse,
        host="matrix.ocf.berkeley.edu",
    )

    #
    # Element
    #

    config_element = ConfigMap.from_files(
        name="element",
        files=[Path("config/element/config.json")],
    )
    yield config_element

    deploy_element = Deployment(
        name="element",
        image="vectorim/element-web:latest",
        ports=[80],
    )
    deploy_element.pod_spec().with_configmap_volume(
        name=config_element.get_name(),
        mount_path="/app",
        keys=["config.json"],
    )
    yield deploy_element

    svc_element = Service(
        name="element",
        selector=deploy_element.get_selector(),
        port_on_pod=80,
        port_on_service=80,
    )
    yield svc_element

    yield Ingress.from_svc(
        svc_element,
        host="chat.ocf.berkeley.edu",
    )

    #
    # IRC Bridge
    #

    sts_irc_bridge = StatefulSet(
        name="irc-bridge",
        image="matrixdotorg/matrix-appservice-irc:latest",
        ports=[9999],
        service_name="irc-bridge",
    )
    yield sts_irc_bridge

    svc_irc_bridge = Service(
        name="irc-bridge",
        selector=sts_irc_bridge.get_selector(),
        port_on_pod=9999,
        port_on_service=80,
    )
